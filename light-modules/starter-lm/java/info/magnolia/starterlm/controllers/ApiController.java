package info.magnolia.starterlm.controllers;

import info.magnolia.starterlm.services.TextService;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/my-api")
public class ApiController {
    @Inject
    private TextService textService;

    @GET
    @Path("/hello")
    @Produces(MediaType.APPLICATION_JSON)
    public Response hello(@QueryParam("name") String name) {
        String message = name != null ? "Hello, " + name + "!" : "Hello, World!";
        String decorated = textService.decorateText(message);

        return Response.ok()
            .entity("{\"message\": \"" + decorated + "\"}")
            .build();
    }
}