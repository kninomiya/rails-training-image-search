import Vue from "vue";
import {Component, Prop} from "vue-property-decorator";

@Component({
    name: "app-header",
    template: require ("../templates/app-header.vue.html"),
})
export default class AppHeaderComponent extends Vue {

    @Prop({default: ""})
    private _contentTitle: string;

    public data(): any {

        return {

            contentTitle: this._contentTitle,
        }
    }
}