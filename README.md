# helm-charts
Repository for public helm charts


## Helpful repository references

https://github.com/ameijer/k8s-as-helm


## Helm Workflow 

![image](https://user-images.githubusercontent.com/115110972/198219476-0248e13f-dc8c-4303-b853-33e3473a8763.png)


```mermaid
graph LR
    C{Public Repo: Helm Charts}
    C -->|Passes Down Charts| D[Private Repo: Other app]
    C -->|Passes Down Charts| E[Private Repo: auth-services] 
    D --> F[fa:fa-cloud AWS]
    E --> F[fa:fa-cloud AWS]

    id1>Local DevVaules.yaml in Private Repos will overide helm values] --> E[Private Repo: auth-services]

    click C "https://github.com/htaic/helm-charts" _blank
    click F "https://us-west-2.console.aws.amazon.com/eks/home?region=us-west-2#/clusters" _blank

  
  ```
