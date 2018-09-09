// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import Vue from "vue";
import VueMaterial from "vue-material";

import LessonShowCaseComponent from "./components/lesson-show-case";
import AppHeaderComponent from "./components/app-header";
import AppFooterComponent from "./components/app-footer";
import LessonAdminDashboardComponent from "./components/lesson-admin-dashboard";

Vue.use(VueMaterial);

if (document.getElementById("app")) {

    // tslint:disable-next-line:no-unused-expression
    const v = new Vue({
        components: {
            "app-header": AppHeaderComponent,
            "show-case": LessonShowCaseComponent,
            "admin-dashboard":LessonAdminDashboardComponent,
            "app-footer": AppFooterComponent,
        },
        el: "#app"
    });
}
