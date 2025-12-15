import type { Joseki } from "../models/joseki"
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
      throw new Error("Network response was not ok")
    }
  }

  const postJoseki = async (
    joseki: Joseki,
    videoId: string
  ): Promise<void> => {}

  const getJoseki = async (videoId: string): Promise<Array<Joseki>> => {
    return []
  }

  const getVideos = async (joseki: Joseki): Promise<Array<string>> => {
    const response = await fetch(`${baseUrl}/video`, {
      method: "POST",
      headers: { ...headers },
      body: JSON.stringify(new StonesRequest(joseki.stoneList).toJson()),
    })
    if (!response.ok) {
      throw new Error("Network response was not ok")
    }
    const json = await response.json()
    const videoIds: Array<string> = json.data.map((item: any) => item.id)
    return videoIds
  }

  const deleteJoseki = async (
    videoId: string,
    joseki: Joseki
  ): Promise<void> => {}

  return { getHello, postJoseki, getJoseki, getVideos, deleteJoseki }
}

export default useJosekiApi
