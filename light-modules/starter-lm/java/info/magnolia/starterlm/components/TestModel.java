package info.magnolia.starterlm.components;

import info.magnolia.rendering.model.RenderingModelImpl;
import info.magnolia.rendering.model.RenderingModel;
import info.magnolia.rendering.template.RenderableDefinition;
import info.magnolia.rendering.context.RenderingContext;
import info.magnolia.jcr.util.ContentMap;
import info.magnolia.repository.RepositoryManager;
import info.magnolia.starterlm.services.TextService;

import javax.inject.Inject;
import javax.jcr.Node;
import javax.jcr.Session;

public class TestModel<RD extends RenderableDefinition> extends RenderingModelImpl<RD> {
    private ContentMap content;

    @Inject
    private TextService textService;

    public TestModel(Node content, RD definition) {
        super(content, definition, null);
        this.content = new ContentMap(content);
    }

    public ContentMap getRelatedPage() {
        try {
            String relatedPagePath = (String) content.get("relatedPagePath");
            if (relatedPagePath == null || relatedPagePath.isEmpty()) {
                return null;
            }

            // Ensure path starts with /
            if (!relatedPagePath.startsWith("/")) {
                relatedPagePath = "/" + relatedPagePath;
            }

            // Use the session from the content node
            Session session = content.getJCRNode().getSession();
            
            // Check if the path exists in the current workspace
            if (session.nodeExists(relatedPagePath)) {
                Node relatedNode = session.getNode(relatedPagePath);
                return new ContentMap(relatedNode);
            }
            return null;
        } catch (Exception e) {
            return null;
        }
    }

    public String decorateField(String fieldName) {
        if (textService == null) {
            throw new IllegalStateException("TextService is not injected. Make sure the service is registered in config/beans/textService.yaml");
        }
        String fieldValue = (String) content.get(fieldName);
        if (fieldValue == null || fieldValue.isEmpty()) {
            return null;
        }
        return textService.decorateText(fieldValue);
    }
}