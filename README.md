# dark-cyberchef
This is a Dockerfile to create a lightweight cyberchef container with a default solarized dark theme :)

This is regularly build and deployed on Google Cloud here: https://dark-cyberchef-lxapdonpma-nw.a.run.app
```mermaid
flowchart LR
B1[GCP Scheduler] ==> Dockerfile
    subgraph Dockerfile

            A[CyberChef source code] -. downloads to .-> B(Build container)
            B -. edits src and copies to .-> C[App container]
    end
    subgraph GCP
        C -->|publishes to| D[Cloud Run]
    end
```
