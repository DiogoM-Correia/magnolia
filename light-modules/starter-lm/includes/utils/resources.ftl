[#function getWebresourcePath resourcePath lightModuleName="starter-lm"]
    [#return ctx.contextPath + "/.resources/" + lightModuleName + "/webresources" + resourcePath]
[/#function]