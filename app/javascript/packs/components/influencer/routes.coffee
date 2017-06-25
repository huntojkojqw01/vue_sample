import Placeholder from "../placeholder"
import Header      from "../header"
import Footer      from "../footer"
import Login       from "./login"
import Profile     from "./profile/routes"

export default [
  {
    path:       ""
    name:       "login"
    components: { default: Login, footer: Footer }
  },
  {
    path:       "/profile",
    components: { default: Placeholder, header: Header, footer: Footer },
    children:   Profile,
    meta:       { auth: "influencer" }
  }
]
