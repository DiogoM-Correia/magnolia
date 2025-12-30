[#import "/starter-lm/includes/macros/editMode.ftl" as editMode]

[@editMode.wrapContent]
    [#-- Access the model (automatically available as 'model') --]
    [#assign testModel = model!]
    [#assign contentMap = testModel.getContent()!]
    [#assign renderingContext = testModel.getRenderingContext()!]
    
    <div class="test-section py-12 px-8">
        [#-- Access ContentMap --]
        [#if content.headline?has_content]
            <h1 class="text-4xl font-bold mb-4">${content.headline}</h1>
        [/#if]

        [#-- Access JCR Node directly --]
        [#assign jcrNode = testModel.getJcrNode()!]
        [#if jcrNode?has_content]
            <div class="debug-info" style="display:none;">
                Node Name: ${jcrNode.name!}
                Node Path: ${jcrNode.path!}
            </div>
        [/#if]

        [#-- Access JCR Session --]
        [#attempt]
            [#assign websiteSession = testModel.getJcrSession("website")!]
            [#if websiteSession?has_content]
                [#-- Example: Check if a node exists --]
                [#assign homeExists = websiteSession.nodeExists("/home")!]
            [/#if]
        [#recover]
            [#-- Handle error silently --]
        [/#attempt]

        [#-- Use business logic from model --]
        [#if testModel.hasProperty("headline")]
            <p class="text-sm text-gray-500">Headline property exists</p>
        [/#if]
    </div>
[/@editMode.wrapContent]