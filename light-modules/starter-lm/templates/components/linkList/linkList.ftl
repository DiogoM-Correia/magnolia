[#import "/starter-lm/includes/macros/editMode.ftl" as editMode]
[#import "/starter-lm/includes/utils/footer.ftl" as fUtils]

[#assign theme = content.theme!"light"]

[@editMode.wrapContent]
    <div class="px-8 py-6 ${(fUtils.isFooterArea(content) || theme == 'dark')?then('bg-dark-teal text-light-green', 'text-dark-teal')}">
        [#if content.title?has_content]
            <p class="pb-4">${content.title}</p>
        [/#if]

        [@cms.area name="items" /]
    </div>
[/@editMode.wrapContent]