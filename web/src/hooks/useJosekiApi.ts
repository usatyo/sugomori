import type { Joseki } from "../models/joseki"
import type { Video } from "../models/youtube"

const useJosekiApi = () => {
  const baseUrl = import.meta.env.VITE_JOSEKI_API_URL
  const bearerToken = import.meta.env.VITE_JOSEKI_API_BEARER_TOKEN

  const getHello = async () => {
    const response = await fetch(`${baseUrl}/`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${bearerToken}`,
      },
    })
    if (!response.ok) {
      console.error(await response.json())
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

  const getVideos = async (joseki: Joseki): Promise<Array<Video>> => {
    return []
  }

  const deleteJoseki = async (
    videoId: string,
    joseki: Joseki
  ): Promise<void> => {}

  return { getHello, postJoseki, getJoseki, getVideos, deleteJoseki }
}

export default useJosekiApi
