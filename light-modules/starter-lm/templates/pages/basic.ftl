[#import "/starter-lm/includes/utils/resources.ftl" as res]

[@compress single_line=cmsfn.isPublicInstance()]
    <!DOCTYPE html>
    <html lang="${cmsfn.language()!}">
    <head>
        [@cms.page /]

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Karla:ital,wght@0,200..800;1,200..800&display=swap" rel="stylesheet">
        <link href="${res.getWebresourcePath('/img/Magnolia_favicon.png')}" rel="icon" sizes="32x32" type="image/png">
        <link href="${res.getWebresourcePath('/css/styles.css')}" rel="stylesheet">
        <title>${content.title!i18n['page.basic.title']}</title>
    </head>
    <body>
        [@cms.area name="navigation" /]
        
        <div class="flex flex-col justify-between min-h-[calc(100vh-5rem)]">
            [@cms.area name="main" /]
            [@cms.area name="footer" /]
        </div>
    </body>
    </html>
[/@compress]