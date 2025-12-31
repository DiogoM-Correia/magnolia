[#import "/starter-lm/includes/macros/editMode.ftl" as editMode]

[@editMode.wrapContent]
    <div class="test-section py-12 px-8">
        [#if content.headline?has_content]
            <h1 class="text-4xl font-bold mb-4">${content.headline}</h1>
        [/#if]
        
        [#if content.subheadline?has_content]
            <p class="text-xl mb-6">${content.subheadline}</p>
        [/#if]
        
        [#if content.ctaText?has_content && content.ctaLink?has_content]
            <a href="${content.ctaLink}" class="btn-primary">${content.ctaText}</a>
        [/#if]

        [#-- Use Java Model to get related page --]
        [#if model?has_content]
            
            [#assign relatedPage = model.getRelatedPage()!]
            [#if relatedPage?has_content]
                <div class="mt-6 p-4 bg-gray-100 rounded-lg border">
                    <h3 class="text-lg font-semibold mb-2"><strong>Related Page:</strong></h3>
                    [#assign relatedPageNode = cmsfn.asJCRNode(relatedPage)!]
                    [#if relatedPageNode?has_content]
                        [#assign pageLink = cmsfn.link(relatedPageNode)!]
                        [#assign pageTitle = relatedPage.title!relatedPage.name!relatedPageNode.name]
                                                    
                        [#if pageLink?has_content]
                            <a href="${pageLink}" class="text-dark-teal hover:underline font-semibold text-lg">
                                ${pageTitle} →
                            </a>
                        [#else]
                            <p class="text-gray-600">
                                <strong>${pageTitle}</strong> (link could not be generated)
                            </p>
                        [/#if]
                    [/#if]
                </div>
            [/#if]
        [/#if]
    </div>
[/@editMode.wrapContent]