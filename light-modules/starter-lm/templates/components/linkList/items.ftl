[#if components?has_content]
    <ul class="space-y-2">
        [#list components as component]
            <li>
                [@cms.component content=component /]
            </li>
        [/#list]
    </ul>
[/#if]