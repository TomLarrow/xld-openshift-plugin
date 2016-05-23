<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->


# login to openshift and switch projects
<#if deployed.container.authentication == "Basic">
    ${deployed.container.ocHome}/oc login --server=${deployed.container.serverUrl} -u ${deployed.container.username} -p '${deployed.container.password}' --insecure-skip-tls-verify=true
</#if>
<#if deployed.container.authentication == "Token">
    ${deployed.container.ocHome}/oc login --server=${deployed.container.serverUrl} --token=${deployed.container.openshiftToken} --insecure-skip-tls-verify=true
</#if>
<#if deployed.container.authentication == "Basic Alias">
    ${deployed.container.ocHome}/oc login --server=${deployed.container.serverUrl} -u ${deployed.container.credential.username} -p '${deployed.container.credential.password}' --insecure-skip-tls-verify=true
</#if>
<#if deployed.container.authentication == "Token Alias">
    ${deployed.container.ocHome}/oc login --server=${deployed.container.serverUrl} --token=${deployed.container.credential.openshiftToken} --insecure-skip-tls-verify=true
</#if>

${deployed.container.ocHome}/oc project ${deployed.project}

# determine if this app already exists, if not deploy a new one
echo "create new app automatically"
${deployed.container.ocHome}/oc new-app <#if deployed.dockerUrl?has_content>${deployed.dockerUrl}/</#if><#if deployed.dockerOrganization?has_content>${deployed.dockerOrganization}/</#if>${deployed.dockerName}<#if deployed.dockerTag?has_content>:${deployed.dockerTag}</#if> --name=${deployed.appName}
${deployed.container.ocHome}/oc expose service ${deployed.appName}
${deployed.container.ocHome}/oc status