package info.magnolia.starter-lm.components;

import info.magnolia.rendering.model.RenderingModel;
import info.magnolia.rendering.model.RenderingModelImpl;
import info.magnolia.rendering.template.RenderableDefinition;
import info.magnolia.rendering.context.RenderingContext;
import info.magnolia.jcr.util.ContentMap;
import info.magnolia.jcr.util.NodeTypes;
import info.magnolia.jcr.util.NodeUtil;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

public class TestModel<RD extends RenderableDefinition> extends RenderingModelImpl<RD> {
    private ContentMap content;
    private RenderingContext renderingContext;

    public TestModel(Node content, RD definition, RenderingContext renderingContext) {
        super(content, definition, renderingContext);
        this.content = new ContentMap(content);
        this.renderingContext = renderingContext;
    }

    public ContentMap getContent() {
        return content;
    }

    public RenderingContext getRenderingContext() {
        return renderingContext;
    }

    public Session getJcrSession(String workspace) throws RepositoryException {
        return renderingContext.getJcrSession(workspace);
    }

    public Node getJcrNode() {
        return content.getJcrNode();
    }

    public ContentMap getRelatedPage() throws RepositoryException {
        String relatedPagePath = content.get("relatedPagePath", String.class);
        if (relatedPagePath.isEmpty()) {
            return null;
        }

        Session session = renderingContext.getJcrSession("website");
        if(session.nodeExists(relatedPagePath)) {
            Node relatedNode = session.getNode(relatedPagePath);
            return new ContentMap(relatedNode);
        }
        return null;
    }

    public boolean hasProperty(String propertyName) {
        return content.containsKey(propertyName) && content.get(propertyName) != null;
    }
}