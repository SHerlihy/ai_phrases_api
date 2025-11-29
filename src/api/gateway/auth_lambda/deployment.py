import os

AUTH_KEY = os.environ.get('AUTH_KEY')
USER_ID = "testUser"

def lambda_handler(event, context):
    print(event)

    # Retrieve request parameters from the Lambda function input:
    headers = event['headers']
    queryStringParameters = event['queryStringParameters']

    # Perform authorization to return the Allow policy for correct parameters
    # and the 'Unauthorized' error, otherwise.
    if (queryStringParameters['authKey'] == AUTH_KEY):
        response = generateAllow(USER_ID, event['methodArn'])
        print('authorized')
        return response
    else:
        print('unauthorized')
        response = generateDeny(USER_ID, event['methodArn'])
        return response
    # Help function to generate IAM policy


def generatePolicy(principalId, effect, resource):
    authResponse = {}
    authResponse['principalId'] = principalId
    if (effect and resource):
        policyDocument = {}
        policyDocument['Version'] = '2012-10-17'
        policyDocument['Statement'] = []
        statementOne = {}
        statementOne['Action'] = 'execute-api:Invoke'
        statementOne['Effect'] = effect
        statementOne['Resource'] = resource
        policyDocument['Statement'] = [statementOne]
        authResponse['policyDocument'] = policyDocument

    authResponse['context'] = {
        "stringKey": "stringval",
        "numberKey": 123,
        "booleanKey": True
    }

    return authResponse


def generateAllow(principalId, resource):
    return generatePolicy(principalId, 'Allow', resource)


def generateDeny(principalId, resource):
    return generatePolicy(principalId, 'Deny', resource)
