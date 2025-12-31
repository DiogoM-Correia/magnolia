[#import "/starter-lm/includes/macros/editMode.ftl" as editMode]
[#import "/starter-lm/includes/macros/image.ftl" as image]

[@editMode.wrapContent]
    <div class="product-card border rounded-lg p-6 hover:shadow-lg transition-shadow">
        [#if content.productImage?has_content]
            <div class="mb-4">
                [@image.renderImage content.productImage content.productName!"" /]
            </div>
        [#/if]

        [#if content.productName?has_content]
            <h3 class="text-2xl font-bold mb-2">
                [#if content.productLink?has_content]
                    <a href="${content.productLink}" class="text-dark-teal hover:underline">
                [/#if]
                ${content.productName}
                [#if content.productLink?has_content]
                    </a>
                [/#if]
            </h3>
        [/#if]

        [#if content.productDescription?has_content]
            <div class="mb-4 text-gray-700">
                ${cmsfn.decode(content.productDescription)}
            </div>
        [/#if]

        [#if content.productPrice?has_content]
            <div class="text-3xl font-bold text-dark-teal mb-4">
                $${content.productPrice}
            </div>
        [/#if]

        [#if content.featured == "true"]
            <span class="inline-block bg-yellow-400 text-black px-2 py-1 rounded text-sm font-semibold">
                ${i18n['product.featured']}
            </span>
        [/#if]

        [#if content.category?has_content]
            <span class="inline-block bg-gray-200 px-2 py-1 rounded text-sm ml-2">
                ${content.category}
            </span>
        [/#if]

        [#if content.tags?has_content]
            <div class="mb-4">
                [#assign tagList = content.tags?split(",")]
                [#list tagList as tag]
                    <span class="inline-block bg-blue-100 text-blue-7800 px-2 py-1 rounded text-xs mr-1">
                        ${tag?trim}
                    </span>
                [/#list]
            </div>
        [/#if]
    </div>
[/@editMode.wrapContent]