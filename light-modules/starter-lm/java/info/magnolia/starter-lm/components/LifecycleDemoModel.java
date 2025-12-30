package info.magnolia.starterlm.components; 

import info.magnolia.rendering.model.RenderingModel;
import info.magnolia.rendering.model.RenderingModelImpl;
import info.magnolia.rendering.template.RenderableDefinition; 
import info.magnolia.rendering.context.RenderingContext;
import info.magnolia.jcr.util.ContentMap;

import javax.jcr.Node;
import java.util.ArrayList;
import java.util.List;

public class LifecycleDemoModel<RD extends RenderableDefinition> extends RenderingModel<RD> {
    private List<String> lifecycleEvents = new ArrayList<>();

    public LifecycleDemoModel(Node content, RD definition, RenderingContext renderingContext) {
        super(content, definition, renderingContext);
        lifecycleEvents.add("1. Constructor called");
        lifecycleEvents.add("2. Content: " + content.getPath());
        lifecycleEvents.add("3. Definition: " + definition.getName());
    }

    public List<String> getLifecycleEvents() {
        return lifecycleEvents;
    }

    public void onRender() {
        lifecycleEvents.add("4. onRender() method called");
    }
}