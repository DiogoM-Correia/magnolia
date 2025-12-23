[#import "/starter-lm/includes/macros/editMode.ftl" as editMode]
[#import "/starter-lm/includes/utils/footer.ftl" as fUtils]

[@editMode.wrapContent]
    <div class="py-6 px-8 [#if !fUtils.isFooterArea(content)]bg-light-green[/#if]">
        [#if content.text?has_content]
            ${cmsfn.decode(content).text}
        [/#if]
    </div>
[/@editMode.wrapContent]