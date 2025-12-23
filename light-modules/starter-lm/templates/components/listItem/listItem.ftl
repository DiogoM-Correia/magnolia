[#if content.label?has_content && content.url?has_content]
    <a href='${content.url}' target='_blank' class='hover:underline' rel='noreferrer'>
        ${content.label}
    </a>
[/#if]