[#import "/starter-lm/include/macros/editMode.ftl" as editMode]

[@editMode.wrapContent]
    <div class="debug-panel p-4 bg-gray-100 border">
        <h3>Magnolia Internals Debug</h3>

        [#-- 1. Access RenderingContext (available as 'ctx') --]
        <div class="mb-4">
            <h4>RenderingContext:</h4>
            <ul>
                <li>Current Page: ${ctx.getPage()!}</lib>
                <li>Current Site: ${ctx.getSite()!}</li>
                <li>Language: ${ctx.getLocale()!}</li>
                <li>Aggregation State: ${ctx.getAggregationState()!}</li>
            </ul>
        </div>

        [#-- 2. Access ContentMap (available as 'content') --]
        <div class="mb-4">
            <h4>ContentMap Properties:</h4>
            <ul>
                [#list content?keys as key]
                    <li>${key}: ${content[key]!}</li>
                [/#list]
            </ul>
        </div>

        [#-- 3. Access JCR Node directly --]
        <div class="mb-4">
            <h4>JCR Node Info:</h4>
            [#assign jcrNode = cmsfn.asJCRNode(content)!]
            [#if jcrNode?has_content]
                <ul>
                    <li>Node Name: ${jcrNode.name!}</li>
                    <li>Node Path: ${jcrNode.path!}</li>
                    <li>Node Type: ${jcrNode.primaryNodeType.name!}</li>
                    <li>Has Children: ${jcrNode.hasNodes()?c}</li>
                </ul>
            [/#if]
        </div>

        [#-- 4. Access JCR Session --]
        <div class="mb-4">
            <h4>JCR Session Access:</h4>
            [#attempt]
                [#assign websiteSession = ctx.getJCRSession("website")!]
                [#if websiteSession?has_content]
                    <ul>
                        <li>Workspace: website</li>
                        <li>Root Node Exists: ${websiteSession.nodeExists("/")?c}</li>
                        <li>Home Node Exists: ${websiteSession.nodeExists("/home")?c}</li>
                    </ul>
                [/#if]
            [#recover]
                <p class="text-red-500">Error accessing JCR Session: ${.error.message!}</p>
            [/#attempt]
        </div>

        [#-- 5. Nagivate JCR tree --]
        <div class="mb-4">
            <h4>JCR Navigation:</h4>
            [#if jcrNode?has_content]
                [#attempt]
                    [#assign parentNode = jcrNode.parent!]
                    [#if parentNode?has_content]
                        <p>Parent: ${parentNode.path!}</p>
                    [/#if]

                    [#assign children = cmsfn.children(content, "mgnl:component")!]
                    <p>Child Components: ${children?size!0}</p>
                [#recover]
                    <p class="text-red-500">Navigation error</p>
                [#attempt]
            [/#if]
        </div>
    </div>
[/@editMode.wrapContent]