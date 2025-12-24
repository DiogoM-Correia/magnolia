[#import "/starter-lm/includes/macros/editMode.ftl" as editMode]
[#import "/starter-lm/includes/utils/resources.ftl" as res]

[#function getPageTitle page]
    [#return page.navigationTitle!page.title!page['@name']]
[/#function]

[#assign navRoot = navfn.rootPage(content)!]

[#if navRoot?has_content]
    [#assign rootLink = cmsfn.link(navRoot)!]
    [#assign navItems = navfn.navItems(navRoot)]
[/#if]

[@editMode.wrapContent]
    <header class='sticky top-0 h-20 px-8 flex justify-between items-center bg-white border-b ${"border-[#a9a9a9]"}'>
        <a href='${rootLink!}' aria-label="${i18n['area.navigation.logo.link']}">
            <img src='${res.getWebresourcePath("/img/Magnolia_logo.png")}' class='w-52' alt='${i18n["logo.alt"]}' />
        </a>

        [#if navRoot?has_content || navItems?has_content]
            <nav>
                <ul class='flex space-x-6'>
                    [#if navItems?has_content]
                        [#list navItems as navItem]
                            <li>
                                <a href="${cmsfn.link(navItem)!}" class="navbar-item">${getPageTitle(navItem)}</a>
                            </li>
                        [/#list]
                    [/#if]
                </ul>
            </nav>
        [/#if]
    </header>
[/@editMode.wrapContent]