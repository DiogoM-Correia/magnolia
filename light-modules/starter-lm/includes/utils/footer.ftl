[#function isFooterArea content]
    [#local parentArea = cmsfn.parent(content, "mgnl:area")!]
    
    [#return parentArea?has_content && parentArea.@name == "footer"]
[/#function]