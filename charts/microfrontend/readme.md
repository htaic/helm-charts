# Microfront end helm chart

A sample library for dealing with microfront ends that deploy behind traefik.

## Installation

clone the [.helm](https://github.com/htaic/.helm) repo into your source code and move the example file out:

```
git clone https://github.com/htaic/.helm.git
mv ./.helm/microfrontend/values.yaml.Example ./DevValues.yaml
```

## Usage

Update the dev yaml to reflect the correct image name, ports, pull policy, and rewrite path (domain). Run the following command to deploy against an eks (after defining/declaring the variables)
```
aws eks update-kubeconfig --region $AWS_DEFAULT_REGION --name $AWS_EKS_NAME
cd ./.helm/microfrontend
helm upgrade --install -f ../../DevValues.yaml $MYSERVICENAME .
```

## Contributing
Pull requests are welcome. For major changes, please open a Jira DEVO ticket first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
Oh what's code licensed internally 	:wink:
