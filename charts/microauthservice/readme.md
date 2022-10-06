# Microfront end helm chart

A Public chart for deploying with hanwha auth services.

## Installation

Clone the [helm charts](https://github.com/htaic/helm-charts) repo into your source code and move the example file out:

```
git clone https://github.com/htaic/helm-charts.git
mv ./helm-charts/charts/microauthservice/values.yaml.Example ./DevValues.yaml
```

## Usage

```
aws eks update-kubeconfig --region $AWS_DEFAULT_REGION --name $AWS_EKS_NAME
cd ./helm-charts/charts/microauthservice
helm upgrade --install -f ../../DevValues.yaml $MYSERVICENAME .
```

## Contributing

Pull requests are welcome. For major changes, please open a Jira DEVO ticket first to discuss what you would like to change.

Please make sure to update tests as appropriate.
