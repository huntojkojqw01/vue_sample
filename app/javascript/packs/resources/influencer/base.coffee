import Base from "../base"

class InfluencerBase extends Base
  @endpoint: ->
    "#{super}/admin"

export default InfluencerBase
