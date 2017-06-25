import Index from "./index"
import Edit  from "./edit.vue"

export default [
  { path: "",         name: "influencers",     component: Index }
  { path: "new",      name: "new influencer",  component: Edit }
  { path: ":id/edit", name: "edit influencer", component: Edit }
]
