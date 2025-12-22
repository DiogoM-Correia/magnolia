<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${content.title!""}</title>
</head>
<body>
    <header>
        <h1>${content.title!"Welcome to Magnolia"}</h1>
    </header>
    
    <main>
        <#if content.body??>
            <div>
                ${content.body}
            </div>
        </#if>
        
        <#if content.areas??>
            <#list content.areas as area>
                <@cms.area name=area />
            </#list>
        </#if>
    </main>
    
    <footer>
        <p>&copy; ${.now?string("yyyy")} Magnolia CMS</p>
    </footer>
</body>
</html>

