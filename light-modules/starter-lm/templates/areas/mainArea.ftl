[#-- Get parent page name for category lookup --]
[#assign parentPage = cmsfn.parent(content, "mgnl:page")!]
[#assign categoryName = (parentPage['@name'])!(content['@name'])!]

[#assign subcategories = []]

[#if categoryName?has_content]
    [#attempt]
        [#assign jcrSession = ctx.getJCRSession("category")!]
        [#assign categoryPath = "/" + categoryName]
        
        [#if jcrSession?has_content && jcrSession.nodeExists(categoryPath)]
            [#assign currentCategory = jcrSession.getNode(categoryPath)]
            [#list cmsfn.children(currentCategory, "mgnl:category")! as child]
                [#assign subcategories = subcategories + [child]]
            [/#list]
        [/#if]
    [#recover]
    [/#attempt]
[/#if]

[#-- Display components first (includes auto-generated welcome text) --]
[#if components?has_content]
    [#list components as component]
        [@cms.component content=component /]
    [/#list]
[/#if]

[#-- Display subcategories --]
[#if subcategories?has_content]
    <div class="mb-8 space-y-4">
        [#list subcategories as subcategory]
            [#assign subcatName = subcategory.name!]
            [#assign subcatTitle = subcategory.title!subcatName]
            [#assign parentPageName = parentPage['@name']!]
            [#assign pageNode = cmsfn.nodeByPath("/" + parentPageName + "/" + subcatName)!]
            [#assign categoryLink = (pageNode?has_content)?then(cmsfn.link(pageNode)!"", "")]
            
            <div class="border border-gray-200 rounded-lg p-4 hover:shadow-lg transition-shadow">
                [#if categoryLink?has_content]<a href="${categoryLink}" class="block">[/#if]
                    <h3 class="text-xl font-semibold text-dark-teal mb-2">${subcatTitle}</h3>
                    [#if subcategory.description?has_content]
                        <p class="text-gray-600">${subcategory.description}</p>
                    [/#if]
                [#if categoryLink?has_content]</a>[/#if]
            </div>
        [/#list]
    </div>
[/#if]