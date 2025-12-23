[#import "/starter-lm/includes/utils/resources.ftl" as res]
[#import "/starter-lm/includes/macros/editMode.ftl" as editMode]

[@editMode.wrapContent]
    <footer class='bg-dark-teal text-white px-8'>
        <div class='grid grid-cols-3 gap-12'>
            <a href='https://www.magnolia-cms.com' target='_blank' rel='noreferrer' class='inline'>
                <img
                class='py-6 max-w-64'
                src='${res.getWebresourcePath("/img/Magnolia_icon_white.svg")}'
                alt='${i18n["logo.alt"]}'
                />
            </a>

            <div class='col-span-2'>
                [#if components?has_content]
                    [#list components as component]
                        [@cms.component content=component /]
                    [/#list]
                [/#if]
            </div>
        </div>

        <div class='text-center text-light-green py-6'>
            <p>${i18n['area.footer.copyright']}</p>
        </div>
    </footer>
[/@editMode.wrapContent]