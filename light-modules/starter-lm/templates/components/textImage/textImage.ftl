[#import "/starter-lm/includes/macros/editMode.ftl" as editMode]
[#import "/starter-lm/includes/macros/image.ftl" as image]

[@editMode.wrapContent]
    <div class='py-6 px-8'>
        <div class='grid grid-cols-1 md:grid-cols-2 gap-6'>
            [#if content.text?has_content]
                <div>
                    ${cmsfn.decode(content).text}
                </div>
            [/#if]

            [#if image.hasImage(content.image!"")]
                <div>
                    [@image.renderImage content.image content.altText!"" /]

                    [#if content.caption?has_content]
                        <p class="text-center">${content.caption}</p>
                    [/#if]
                </div>
            [/#if]
        </div>
    </div>
[/@editMode.wrapContent]