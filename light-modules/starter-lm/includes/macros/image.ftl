[#function hasImage imageId=""]
    [#return imageId?has_content && damfn.getAssetLink(imageId)?has_content]
[/#function]

[#macro renderImage imageId altText=""]
    <img 
        src="${damfn.getAssetLink(imageId)!}"
        [#if altText?has_content]alt="${altText}"[/#if]
    />
[/#macro]