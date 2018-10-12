import axios from "axios";
import {AxiosRequestConfig} from "axios";

import Vue from "vue";
import {Component, Prop} from "vue-property-decorator";
import LessonShowCaseModel from "../models/lesson-show-case";

@Component({
    template: require ("../templates/lesson-show-case.vue.html"),
})
export default class LessonShowCaseComponent extends Vue {
    @Prop({default: []})
    private _images: any[];
    @Prop({default: ""})
    private _keyword: string;

    private vm: LessonShowCaseModel;

    get imageInActiveCssClass(): any {
        const result = {};

        this.$data.vm.images.forEach((value, index) => {
            result[value.id] = {"md-inactive" : value.selected === false};
        });

        return result;
    }
    public data(): any {
        return {
            vm: new LessonShowCaseModel(
                this._images,
                this._keyword,
            ),
        };
    }

    public onClickSearch() {

        const searchForm = this.$refs.searchForm as HTMLFormElement;
        searchForm.submit();
    }

    public onClickClear() {

        this.$data.vm.images = this.$data.vm.images.map((value, index) => {
            value.selected = false;
            return value;
        });
    }

    public async onClickSave(this: any) {
        const element = this.$refs.loadingArea as HTMLElement;

        const selectedImages = this.$data.vm.images.filter((value) => {
            return value.selected === true;
        });
        element.style.display = "block";
        const config: AxiosRequestConfig = {
            headers: {"Content-Type" : "application/json"}
        }
        axios
        // .post("/api/lsusers", {images: selectedImages}, config)
            .post("/questions_image", {images: selectedImages}, config)
            .then( (response) => {
                console.log(response)
                // console.log({images: selectedImages})
                element.style.display = "none";
            })
            .catch( (error) => {
                console.log(error)
                element.style.display = "none";
            });
    }

    public onClickSelectImage(imageId: string) {

        this.$data.vm.images = this.$data.vm.images.map((value, index) => {
            if (value.id === imageId) {
                value.selected = !value.selected;
            }
            return value;
        });
    }
}