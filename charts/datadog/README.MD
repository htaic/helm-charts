# TO install APM pods plrease follow https://docs.datadoghq.com/tracing/trace_collection/automatic_instrumentation/single-step-apm/?tab=kubernetes
1.helm repo add datadog https://helm.datadoghq.com
helm install my-datadog-operator datadog/datadog-operator

2.kubectl create secret generic datadog-secret --from-literal api-key=$DD_API_KEY
3. Kubectl apply -f datadog-agent1.yaml   Note: change env for each env you installing this agent
4. Check all the pods running in hanwha ns.