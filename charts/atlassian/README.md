# atlassian stack

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

atlassian helm package

**This chart is not maintained by the upstream project and any issues with the chart should be raised [here](https://github.com/nicko170/charts/issues/new/choose)**

## Source Code

* <https://github.com/nick170/atlassian>

## Requirements

Kubernetes: `>=1.16.0-0`

## TL;DR

```console
helm repo add nicko170 https://charts.nicko170.au/
helm repo update
helm install atlassian nicko170/atlassian
```

## Installing the Chart

To install the chart with the release name `atlassian`

```console
helm install atlassian nicko170/atlassian
```

## Uninstalling the Chart

To uninstall the `atlassian` deployment

```console
helm uninstall atlassian
```

The command removes all the Kubernetes components associated with the chart **including persistent volumes** and deletes the release.

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install atlassian \
  --set env.TZ="America/New York" \
    nicko170/atlassian
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install atlassian nicko170/atlassian -f values.yaml
```
