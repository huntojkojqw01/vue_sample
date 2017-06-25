import Base from "../base"

class AdminBase extends Base
  @endpoint: ->
    "#{super}/admin"

export default AdminBase
