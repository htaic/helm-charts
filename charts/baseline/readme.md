# K8s baseline

A Public chart for deploying  cluster baseline configurations to support hanwha services.

## Installation

helm dependency build
helm upgrade --install --namespace hanwha --create-namespace baseline .