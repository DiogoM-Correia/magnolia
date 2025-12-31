package info.magnolia.starterlm.components;

import info.magnolia.rendering.model.RenderingModelImpl;
import info.magnolia.rendering.model.RenderingModel;
import info.magnolia.rendering.template.RenderableDefinition;
import info.magnolia.rendering.context.RenderingContext;
import info.magnolia.jcr.util.ContentMap;
import info.magnolia.repository.RepositoryManager;

import javax.jcr.Node;
import javax.jcr.RepositoryException;
import javax.jcr.Session;

public class TestModel<RD extends RenderableDefinition> extends RenderingModelImpl<RD> {
    private ContentMap content;
    private RenderingContext renderingContext;

    public TestModel(Node content, RD definition, RenderingContext renderingContext) {
        super(content, definition, null);
        this.content = new ContentMap(content);
        this.renderingContext = renderingContext;
    }

    public Session getJcrSession(String workspace) throws RepositoryException {
        // Get session from the content node
        Session currentSession = content.getJCRNode().getSession();
        if (currentSession.getWorkspace().getName().equals(workspace)) {
            return currentSession;
        }
        // For different workspace, we'd need RepositoryManager with proper credentials
        // For now, return the current session
        return currentSession;
    }

    public String getDebugInfo() {
        StringBuilder debug = new StringBuilder();
        try {
            Session session = content.getJCRNode().getSession();
            debug.append("Current workspace: ").append(session.getWorkspace().getName());
            debug.append(" | /home exists: ").append(session.nodeExists("/home"));
        } catch (Exception e) {
            debug.append(" | Error: ").append(e.getMessage());
        }
        return debug.toString();
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
            // Note: Component content is usually in 'website' workspace
            if (session.nodeExists(relatedPagePath)) {
                Node relatedNode = session.getNode(relatedPagePath);
                return new ContentMap(relatedNode);
            }
            return null;
        } catch (Exception e) {
            return null;
        }
    }
}