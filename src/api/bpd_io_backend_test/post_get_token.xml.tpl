<policies>
    <inbound>
        <base />
        <set-backend-service base-url="http://${aks_external_ip}/cstariobackendtest/bpd/pagopa/api/v1" />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>