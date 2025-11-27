const serviceFlow = `
    flowchart LR

    Client <--> API
    
    subgraph GRP[Get Role Policy]
        subgraph GRPAllow[Allow]
            GetIds[lambda > s3:GetObject]
        end
    end

    subgraph AWSIAM[IAM Policies]
        subgraph LAIM[Lambda IAM]
            subgraph DRP[Delete Role Policy]
                subgraph DRPAllow[Allow]
                    DeleteDoc[lambda > s3:DeleteObject]
                end
            end

            subgraph URP[Upload Role Policy]
                subgraph URPAllow[Allow]
                    UploadDoc[lambda > s3:PutObject]
                end
            end

            subgraph GRP[Get Role Policy]
                subgraph GRPAllow[Allow]
                    GetIds[lambda > s3:GetObject]
                end
            end
    
            subgraph LRP[Lambda Resource Policy]
                subgraph LRPAllow[Allow]
                    APILambda["API > lambda:InvokeFunction"]
                end
            end
        end
    end
    
    subgraph AWS
    subgraph global

        GRP -.- List
        GRP -.- Get
        URP -.- Upload
        DRP -.- Delete
        
        Bucket -.-> GetIds
        Bucket -.-> UploadDoc
        Bucket -.-> DeleteDoc
        
        LRP -.- Auth
        LRP -.- List
        LRP -.- Get
        LRP -.- Upload
        LRP -.- Delete
        
        API -.-> APILambda

        API{API Gateway}
        Auth[authoriser lambda]
        
        API <--> Auth

        API <-- GET: / --> List
        API <-- GET: /?ids=[ids] --> Get
        API <-- POST: / --> Upload
        API <-- DELETE: /?ids=[ids] --> Delete

        subgraph region
            subgraph authorised
                List[Get all IDs]
                Get[Get by IDs]
                Upload[Upload single]
                Delete[Delete by IDs]
            end

            Bucket[S3 Bucket]

            List <--> Bucket
            Get <--> Bucket
            Upload <--> Bucket
            Delete <--> Bucket
        end
    end
    end
`

export default serviceFlow
