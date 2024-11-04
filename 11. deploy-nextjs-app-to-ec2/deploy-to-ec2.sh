# Define your EC2 instance ID and Docker command
INSTANCE_ID="i-028b04a54d22eddbf"

APP_CONTAINER_NAME="nextjs-app"
APP_CONTAINER_IMAGE="$CI_REGISTRY_IMAGE:${CI_COMMIT_SHA:0:8}"

DOCKER_LOGIN_COMMAND="echo $CI_REGISTRY_PASSWORD | docker login $CI_REGISTRY -u $CI_REGISTRY_USER --password-stdin"
DOCKER_PULL_COMMAND="docker pull $APP_CONTAINER_IMAGE"

# Single-line CONTAINER_STOP_COMMAND to avoid parsing errors
CONTAINER_STOP_COMMAND="if [ \$(docker ps -q -f name=$APP_CONTAINER_NAME) ]; then docker stop $APP_CONTAINER_NAME && docker rm $APP_CONTAINER_NAME; if [ \$? -eq 0 ]; then echo 'Container stopped successfully.'; else echo 'Failed to stop the container.'; exit 1; fi; else echo 'Container $APP_CONTAINER_NAME is not running. Skipping stop command.'; fi"

CONTAINER_START_COMMAND="docker run -d --restart unless-stopped -p 80:3000 --name $APP_CONTAINER_NAME $APP_CONTAINER_IMAGE"

# Send the Docker command to the EC2 instance
COMMAND_ID=$(aws ssm send-command \
    --document-name "AWS-RunShellScript" \
    --targets "Key=instanceIds,Values=$INSTANCE_ID" \
    --parameters commands="[\"$DOCKER_LOGIN_COMMAND\", \"$DOCKER_PULL_COMMAND\", \"$CONTAINER_STOP_COMMAND\", \"$CONTAINER_START_COMMAND\"]" \
    --query "Command.CommandId" \
    --output text)

echo "Command sent. Command ID: $COMMAND_ID"

# Wait for the command to complete
while true; do
    STATUS=$(aws ssm list-command-invocations \
        --command-id "$COMMAND_ID" \
        --details \
        --query "CommandInvocations[0].Status" \
        --output text)

    echo "Current Status: $STATUS"

    if [[ "$STATUS" == "Success" || "$STATUS" == "Failed" || "$STATUS" == "TimedOut" || "$STATUS" == "Cancelled" ]]; then
        break
    fi

    sleep 2  # Wait for a few seconds before checking again
done

# Get the output of the command
OUTPUT=$(aws ssm list-command-invocations \
    --command-id "$COMMAND_ID" \
    --details \
    --query "CommandInvocations[0].CommandPlugins[0].Output" \
    --output text)

# Print the final output
echo "Final Output:"
echo "$OUTPUT"

# Check if the command was successful
if [[ "$STATUS" == "Success" ]]; then
    echo "Docker command executed successfully."
    exit 0  # Success
else
    echo "Docker command failed with status: $STATUS"
    exit 1  # Fail
fi
