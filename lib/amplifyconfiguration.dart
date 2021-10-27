const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "Superday": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://an5m2b625rhyzd5vni2zhtfmee.appsync-api.eu-west-1.amazonaws.com/graphql",
                    "region": "eu-west-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-lj2aeanxbjd65cavotdq7lczcu"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://an5m2b625rhyzd5vni2zhtfmee.appsync-api.eu-west-1.amazonaws.com/graphql",
                        "Region": "eu-west-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-lj2aeanxbjd65cavotdq7lczcu",
                        "ClientDatabasePrefix": "Superday_API_KEY"
                    },
                    "Superday_AWS_IAM": {
                        "ApiUrl": "https://an5m2b625rhyzd5vni2zhtfmee.appsync-api.eu-west-1.amazonaws.com/graphql",
                        "Region": "eu-west-1",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "Superday_AWS_IAM"
                    },
                    "Superday_AMAZON_COGNITO_USER_POOLS": {
                        "ApiUrl": "https://an5m2b625rhyzd5vni2zhtfmee.appsync-api.eu-west-1.amazonaws.com/graphql",
                        "Region": "eu-west-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "Superday_AMAZON_COGNITO_USER_POOLS"
                    }
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-west-1:6e6a7a21-3520-4186-aa51-ed00d271d6a8",
                            "Region": "eu-west-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-west-1_sF9SjNm9P",
                        "AppClientId": "1ejbkqp8tjlr0rke74vk7ivkmd",
                        "Region": "eu-west-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "loginMechanisms": [],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                }
            }
        }
    }
}''';