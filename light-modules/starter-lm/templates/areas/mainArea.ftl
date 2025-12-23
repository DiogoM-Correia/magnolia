[#if components?has_content]
    <div>
        [#list components as component]
            [@cms.component content=component /]
        [/#list]
    </div>
[/#if]