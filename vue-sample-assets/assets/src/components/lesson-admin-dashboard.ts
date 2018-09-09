import Vue from "vue";
import {Component, Prop} from "vue-property-decorator";
import LessonAdminDashboardModel from "../models/lesson-admin-dashboard";

@Component({
    template: require ("../templates/lesson-admin-dashboard.vue.html"),
})
export default class LessonAdminDashboardComponent extends Vue {
    @Prop({default: []})
    private _lessons: any[];
    @Prop({default: []})
    private _breadcrumbs: any[];

    @Prop({default: ""})
    private _createPath: string;

    private vm: LessonAdminDashboardModel;

    public data(): any {
        return {
            vm: new LessonAdminDashboardModel(
                this._lessons,
                this._breadcrumbs,
                this._createPath
            ),
        };
    }
    public onClickNew() {
        console.log("onClick new lesson contents.");
        const submitForm = this.$refs.dashboardForm as HTMLFormElement
        submitForm.submit();
    }

    public async onClickDelete(this:any, lessonId: string) {
        //TODO: 削除リクエストを送信 (DELETE /lscontents/{lessonId})
    }
}
