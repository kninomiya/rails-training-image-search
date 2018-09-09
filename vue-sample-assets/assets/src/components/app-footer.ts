import Vue from "vue";
import {Component, Prop} from "vue-property-decorator/lib/vue-property-decorator";
import moment from "moment";

@Component({
    template: require("../templates/app-footer.vue.html")
})
export default class AppFooterComponent extends Vue {

    @Prop({default: ""})
    private _copyright: string;


    public data(): any {

        const year = moment().format("Y");
        return {
            copyright: `&copy; ${year} ${this._copyright}`
        }
    }

}