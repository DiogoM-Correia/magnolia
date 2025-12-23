import CreatePagePlugin from "@magnolia/cli-create-page-plugin";
import CreateComponentPlugin from "@magnolia/cli-create-component-plugin";
import CreateVirtualUriPlugin from "@magnolia/cli-create-virtual-uri-plugin";
import CreateContentTypePlugin from "@magnolia/cli-create-content-type-plugin";
import CreateAppPlugin from "@magnolia/cli-create-app-plugin";
import CreateLightModulePlugin from "@magnolia/cli-create-light-module-plugin";
import StartPlugin from "@magnolia/cli-start-plugin";
export default {
  analytics: {
    enabled: true,
    // Set to false to turn off analytics
    uuid: "03529684-69a2-402a-ac54-d59de1d8e88e"
  },
  // Logger configuration
  // see: https://github.com/winstonjs/winston#logging for logging levels explanation
  logger: {
    filename: './mgnl.error.log',
    fileLevel: 'debug',
    consoleLevel: 'info'
  },
  // Here you can add plugins you want to use with MGNL CLI
  plugins: [new CreatePagePlugin({
      framework: '@magnolia/cli-freemarker-prototypes'
    }), new CreateComponentPlugin({
      framework: '@magnolia/cli-freemarker-prototypes'
    }), new CreateVirtualUriPlugin(),
    new CreateContentTypePlugin(),
    new CreateAppPlugin(),
    new CreateLightModulePlugin(),
    new StartPlugin({
      tomcatPath: './.magnolia/apache-tomcat'
    })
  ],
  lightModulesPath: "./light-modules",
  lightModule: "starter-lm"
};
