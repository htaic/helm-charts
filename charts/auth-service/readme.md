# Microfront end helm chart

A Public chart for deploying with hanwha auth services.

## Installation

clone the [helm-charts](https://github.com/htaic/helm-charts) repo into your source code and move the example file out:

```bash
git clone https://github.com/htaic/helm-charts.git
mv ./helm-charts/charts/auth-service/values.yaml ./DevValues.yaml
```

or

```bash
helm repo add htaic https://htaic.github.io/helm-charts
helm repo update
```

## Usage

Update the dev yaml to reflect the correct image name, ports, pull policy, and rewrite path (domain). Run the following command to deploy against an eks (after defining/declaring the variables)

```bash
aws eks update-kubeconfig --region $AWS_DEFAULT_REGION --name $AWS_EKS_NAME
helm dependency build
helm upgrade --install --namespace hanwha -f $VALUES_FILE auth-service ./helm-charts/charts/auth-service
```

or

```bash
aws eks update-kubeconfig --region $AWS_DEFAULT_REGION --name $AWS_EKS_NAME
helm repo update
helm upgrade --install --atomic --namespace hanwha -f $VALUES_FILE auth-service htaic/auth-service
```

## Contributing

Pull requests are welcome. For major changes, please open a Jira DEVO ticket first to discuss what you would like to change.

Please make sure to update tests as appropriate.
