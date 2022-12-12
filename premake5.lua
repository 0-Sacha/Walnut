
VULKAN_SDK = os.getenv("VULKAN_SDK")
if (VULKAN_SDK == nil or VULKAN_SDK == '') then
   error("Coundn't load VulkanSDK, you may want to change the environement variable name or define it; syntax : VULKAN_SDK={path to the SDK directory}")
end

ProjectPublicIncludes["Walnut"] = {
   "%{Project.Walnut}/%{VULKAN_SDK}/Include",
   "%{Project.Walnut}/vendor/glm",
   "%{Project.Walnut}/vendor/imgui",
   "%{Project.Walnut}/vendor/glfw/include",
   "%{Project.Walnut}/vendor/stb_image",
   "%{Project.Walnut}/src"
}

Project["GLFW"] 		= "vendor/GLFW"
Project["ImGui"] 		= "vendor/imgui"

-- Dependencies
group "Dependencies"
	include (Project["GLFW"])
	include (Project["ImGui"])
group ""

project "Walnut"
   kind "StaticLib"
   language "C++"
   cppdialect "C++20"
   staticruntime "off"

   files { "src/**.h", "src/**.cpp" }

   links
   {
       "ImGui",
       "GLFW",
       "%{VULKAN_SDK}/Lib/vulkan-1.lib"
   }

   targetdir 	(project_targetdir .. "/%{prj.name}")
	objdir 		(project_objdir .. "/%{prj.name}")

   filter "system:windows"
      defines { "WL_PLATFORM_WINDOWS" }

   filter "configurations:Debug"
      defines { "WL_DEBUG" }

   filter "configurations:Release"
      defines { "WL_RELEASE" }

   filter "configurations:Dist"
      defines { "WL_DIST" }