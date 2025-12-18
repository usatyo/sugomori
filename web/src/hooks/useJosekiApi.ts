import { toast } from "sonner"
import { Joseki, Stone } from "../models/joseki"
import { StonesRequest } from "../models/josekiApi"

const useJosekiApi = () => {
  const baseUrl = import.meta.env.VITE_JOSEKI_API_URL
  const bearerToken = import.meta.env.VITE_JOSEKI_API_BEARER_TOKEN
  const headers = {
    "Content-Type": "application/json",
    Authorization: `Bearer ${bearerToken}`,
  }

  const getHello = async () => {
    const response = await fetch(`${baseUrl}`, {
      method: "GET",
      headers: { ...headers },
    })
    if (!response.ok) {
      toast.error("APIサーバーへの接続に失敗しました")
    }
  }

  const postJoseki = async (videoId: string, joseki: Joseki): Promise<void> => {
    const response = await fetch(`${baseUrl}/joseki`, {
      method: "POST",
      headers: { ...headers },
      body: JSON.stringify({
        video: { id: videoId },
        joseki: {
          stones: joseki.stoneList.map((stone) => ({
            color: stone.color === "black" ? 0 : 1,
            x: stone.x,
            y: stone.y,
          })),
        },
      }),
    })
    if (!response.ok) {
      toast.error("定石の追加に失敗しました")
    }
  }

  const getJoseki = async (videoId: string): Promise<Array<Joseki>> => {
    const query = new URLSearchParams({ videoId: videoId }).toString()
    const response = await fetch(`${baseUrl}/joseki?${query}`, {
      method: "GET",
      headers: { ...headers },
    })
    if (!response.ok) {
      toast.error("定石の取得に失敗しました")
      return []
    }
    const json = await response.json()
    const josekiList: Array<Joseki> = json.data.map((item: any) => {
      const stones = item.stones
      const stoneList = stones.map(
        (stone: any, index: number) =>
          new Stone(
            stone.color === 0 ? "black" : "white",
            stone.x,
            stone.y,
            index
          )
      )
      return new Joseki(stoneList)
    })
    return josekiList
  }

  const getVideos = async (joseki: Joseki): Promise<Array<string>> => {
    const response = await fetch(`${baseUrl}/video`, {
      method: "POST",
      headers: { ...headers },
      body: JSON.stringify(new StonesRequest(joseki.stoneList).toJson()),
    })
    if (!response.ok) {
      toast.error("動画の取得に失敗しました")
      return []
    }
    const json = await response.json()
    const videoIds: Array<string> = json.data.map((item: any) => item.id)
    return videoIds
  }

  const deleteJoseki = async (
    videoId: string,
    joseki: Joseki
  ): Promise<void> => {
    const response = await fetch(`${baseUrl}/joseki`, {
      method: "DELETE",
      headers: { ...headers },
      body: JSON.stringify({
        video: { id: videoId },
        joseki: {
          stones: joseki.stoneList.map((stone) => ({
            color: stone.color === "black" ? 0 : 1,
            x: stone.x,
            y: stone.y,
          })),
        },
      }),
    })
    if (!response.ok) {
      toast.error("定石の削除に失敗しました")
    }
  }

  return { getHello, postJoseki, getJoseki, getVideos, deleteJoseki }
}

export default useJosekiApi
