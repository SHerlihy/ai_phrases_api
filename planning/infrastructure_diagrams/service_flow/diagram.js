const serviceFlow = `
    flowchart LR

    Client <--> API
    
    subgraph AWS
    subgraph global
        API{API Gateway}
        Auth[authoriser lambda]
        
        API <--> Auth

        subgraph authorised
            List[Get all IDs]
            Get[Get by IDs]
            Upload[Upload single]
            Delete[Delete by IDs]
        end

        API <-- GET: / --> List
        API <-- GET: /?ids=[ids] --> Get
        API <-- POST: / --> Upload
        API <-- DELETE: /?ids=[ids] --> Delete

        Bucket[S3 Bucket]

        List <--> Bucket
        Get <--> Bucket
        Upload <--> Bucket
        Delete <--> Bucket
        
    end
    end
`

export default serviceFlow
