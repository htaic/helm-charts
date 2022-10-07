# Microfront end helm chart

A sample library for dealing with microfront ends that deploy behind traefik.

## Installation

clone the [helm-charts](https://github.com/htaic/helm-charts) repo into your source code and move the example file out:

```bash
git clone https://github.com/htaic/helm-charts.git
mv ./helm-charts/charts/microfrontend/values.yaml ./DevValues.yaml
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
helm upgrade --install --namespace hanwha -f $VALUES_FILE $MYSERVICENAME ./helm-charts/charts/microfrontend
```

or

```bash
aws eks update-kubeconfig --region $AWS_DEFAULT_REGION --name $AWS_EKS_NAME
helm repo update
helm upgrade --install --atomic --namespace hanwha -f $VALUES_FILE $MYSERVICENAME htaic/microfrontend
```

## Contributing

Pull requests are welcome. For major changes, please open a Jira DEVO ticket first to discuss what you would like to change.

Please make sure to update tests as appropriate.
