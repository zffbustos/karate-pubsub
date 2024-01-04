Feature: Create an SQS queue and send messages

Scenario: Create a new empty SQS queue
    Given def command = "aws --endpoint http://sqs.us-west-2.localhost.localstack.cloud:4566 sqs create-queue --queue-name test_queue"
    When def result = karate.exec(command)
    And def numberOfQueues = result.length
    Then assert numberOfQueues > 0

Scenario: Get queue URL
    Given def command = 'aws --endpoint http://sqs.us-west-2.localhost.localstack.cloud:4566 sqs get-queue-url --queue-name test_queue'
    When def result = karate.exec(command)
    Then match result == '#notnull'
 
Scenario: List all SQS 
    Given def command = 'aws --endpoint http://sqs.us-west-2.localhost.localstack.cloud:4566 sqs list-queues'
    When def result = karate.exec(command)
    And def numberOfQueues = result.length
    Then assert numberOfQueues > 0

Scenario: Send one message to the queue
    And def sendMsgCmd = 'aws --endpoint http://sqs.us-west-2.localhost.localstack.cloud:4566 sqs send-message --queue-url http://sqs.us-west-2.localhost.localstack.cloud:4566/000000000000/test_queue --message-body "Message1"'
    When def sendMsgResult = karate.exec(sendMsgCmd)
    Then assert sendMsgResult != null
    * print sendMsgResult
    And match sendMsgResult.MD5OfMessageBody == '#present'
    And match sendMsgResult.MessageId == '#present'

Scenario: Receive message from the queue
    And def receiveMsgCmd = 'aws --endpoint-url=http://sqs.us-west-2.localhost.localstack.cloud:4566 sqs receive-message --queue-url http://sqs.us-west-2.localhost.localstack.cloud:4566/000000000000/test_queue'
    When def receiveMsgResult = karate.exec(receiveMsgCmd)
    Then assert receiveMsgResult != null
    And match receiveMsgResult contains "Body"
    And match receiveMsgResult contains "Message1"

Scenario: Purge queue
    Given def purgeQueueCmd = 'aws --endpoint-url=http://sqs.us-west-2.localhost.localstack.cloud:4566 sqs purge-queue --queue-url http://sqs.us-west-2.localhost.localstack.cloud:4566/000000000000/test_queue'
    When def purgeQueueCmdResult = karate.exec(purgeQueueCmd)
    And print purgeQueueCmdResult
    Then assert purgeQueueCmdResult != null

Scenario: Delete queue
    Given def delQueueCmd = 'aws --endpoint-url=http://sqs.us-west-2.localhost.localstack.cloud:4566 sqs delete-queue --queue-url http://sqs.us-west-2.localhost.localstack.cloud:4566/000000000000/test_queue'
    When def deleteQueueResult = karate.exec(delQueueCmd)
    And print deleteQueueResult
    Then assert deleteQueueResult != null



