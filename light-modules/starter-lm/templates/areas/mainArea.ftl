[#-- Function to get direct subcategories only (no nesting) --]
[#function getSubcategories category jcrSession categoryPath]
    [#local result = []]
    [#local children = cmsfn.children(category, "mgnl:category")!]
    
    [#list children as child]
        [#local result = result + [child]]
    [/#list]
    
    [#return result]
[/#function]

[#-- Get current, parent, and grandparent page names for category lookup --]
[#assign currentPageName = content['@name']!]
[#assign parentPage = cmsfn.parent(content, "mgnl:page")!]
[#assign parentPageName = parentPage['@name']!]
[#assign grandparentPage = cmsfn.parent(parentPage, "mgnl:page")!]
[#assign grandparentPageName = grandparentPage['@name']!]

[#assign subcategories = []]

[#if currentPageName?has_content || parentPageName?has_content]
    [#assign jcrSession = ctx.getJCRSession("category")!]
    
    [#-- Try to find category for current page or parent --]
    [#assign categoryPath = ""]
    
    [#-- Strategy: Use parent page name as category, check multiple paths --]
    [#if parentPageName?has_content]
        [#-- Try parent at root --]
        [#assign testPath1 = "/" + parentPageName]
        [#if jcrSession?has_content && jcrSession.nodeExists(testPath1)]
            [#assign categoryPath = testPath1]
        [#elseif grandparentPageName?has_content]
            [#-- Try parent under grandparent --]
            [#assign testPath2 = "/" + grandparentPageName + "/" + parentPageName]
            [#if jcrSession?has_content && jcrSession.nodeExists(testPath2)]
                [#assign categoryPath = testPath2]
            [/#if]
        [/#if]
    [/#if]
    
    [#-- If still not found, try current page name --]
    [#if !categoryPath?has_content && currentPageName?has_content]
        [#assign testPath3 = "/" + currentPageName]
        [#if jcrSession?has_content && jcrSession.nodeExists(testPath3)]
            [#assign categoryPath = testPath3]
        [/#if]
    [/#if]
    
    [#if categoryPath?has_content && jcrSession?has_content]
        [#assign currentCategory = jcrSession.getNode(categoryPath)]
        [#assign subcategories = getSubcategories(currentCategory, jcrSession, categoryPath)]
    [/#if]
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
            
            [#-- Find page with same name as subcategory --]
            [#assign pageNode = ""]
            [#assign categoryLink = ""]
            
            [#-- Try under current page first, then parent --]
            [#if currentPageName?has_content]
                [#assign pageNode = cmsfn.nodeByPath("/home/" + currentPageName + "/" + subcatName)!]
            [/#if]
            
            [#if !pageNode?has_content && parentPageName?has_content]
                [#assign pageNode = cmsfn.nodeByPath("/home/" + parentPageName + "/" + subcatName)!]
            [/#if]
            
            [#if pageNode?has_content]
                [#assign categoryLink = cmsfn.link(pageNode)!]
            [/#if]
            
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